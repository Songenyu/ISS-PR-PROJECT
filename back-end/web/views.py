from django.shortcuts import HttpResponse
import json
from web.utils.dataUtils import userModel, contentModel, AudithistoryModel
from web.utils.dataUtils import model2dict, QuerySet2ModelList, \
    Query2Dict, Query2DictList, myResponseDict, contentWithUser_Query2DictList, contentWithUser_Query2Dict, \
    auditWithUserContent_Query2DictList, letAuditWithUserContentAndModifyField, numOfModelUnaudit, Audit1Content, now2FromEnd
from django.http import JsonResponse
from django.core import serializers
from django.db.models import Q
from datetime import datetime
from django.core.paginator import Paginator

# from django.forms.models import model_to_dict 不能用

# Create your views here.

def listAllUsers(request):

    return HttpResponse('login error')

def userNameLogin(request):
    if request.method == 'GET':
        username = request.GET.get('username')
        password = request.GET.get('password')

        usersQuery=userModel.filter(username=username,password=password)
        data = Query2Dict(usersQuery)
        print(type(data))
        
        # 序列化与反序列化，是对应json<=>model对象的，model对象有一些奇奇怪怪的属性，要用dumps
        # request.session['user'] = serializers.serialize('json',QuerySet2List(users))
        # 因为保存的时候就是对应的model类型的字符串，所以最后load的时候也是model
        request.session['user'] = json.dumps(data)
        print(request.session['user'])
        
        res=myResponseDict('',data)
        res = JsonResponse(res, safe=False)
        
        return res
        
    return HttpResponse('login error')


def getLoginUser(request):
    jsonUser=request.session['user']
    if jsonUser == '':
        res=myResponseDict('false', '')
        return JsonResponse(res,safe=False)
    data=json.loads(jsonUser)

    res=myResponseDict('',data)
    return JsonResponse(res,safe=False)

# maxSize 是 对应条件下的 未model审核的数量
def getContentByTypeId(request):
    typeid = request.GET.get('typeid')
    checkresult = request.GET.get('checkresult')

    id = request.GET.get('id')
    mediatitle = request.GET.get('mediatitle')
    userid = request.GET.get('userid')
    username = request.GET.get('username')
    fromresource = request.GET.get('fromresource')
    lablefrommodel = request.GET.get('lablefrommodel')

    pageNo = request.GET.get('pageNo')
    pageSize = request.GET.get('pageSize')

    contentsQuery = contentModel.filter(typeid=typeid, checkresult=checkresult)
    if id != '':
        contentsQuery = contentsQuery.filter(id=id)
    if mediatitle != '':
        contentsQuery = contentsQuery.filter(mediatitle=mediatitle)
    if fromresource != '':
        contentsQuery = contentsQuery.filter(fromresource=fromresource)
    if lablefrommodel != '':
        contentsQuery = contentsQuery.filter(lablefrommodel=lablefrommodel)
    if userid != '':
        contentsQuery = contentsQuery.filter(userid=userid)

    paginator = Paginator(contentsQuery, pageSize)
    contentsQuery = paginator.get_page(pageNo)
    contents = contentWithUser_Query2DictList(contentsQuery)
    if username != '':
        for content in contents:
            if content['username'] != username:
                contents.remove(content)

    totals = paginator.count
    maxSize=numOfModelUnaudit(contents)

    data = {'totals': totals, 'medias': contents,'maxSize':maxSize}
    res = myResponseDict('', data)
    return JsonResponse(res, safe=False)

def updateContenAuditResult(request):
    id=request.GET.get('id')
    checkresult=request.GET.get('checkresult')
    lablefrommodel=request.GET.get('lablefrommodel')
    
    now = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    
    a=contentModel \
        .filter(id=id) \
        .update(checkresult=checkresult,lablefrommodel=lablefrommodel,updatetime=now)
    res=myResponseDict('','')
    return JsonResponse(res,safe=False)

def insertHistory(request):
    userid=request.GET.get('userid')
    contentid=request.GET.get('contentid')
    method=request.GET.get('method')
    pass_field=request.GET.get('pass_field')
    reason = request.GET.get('reason')
    
    userQuery=userModel.filter(id=userid)
    user=userQuery[0]
    
    contentQuery=contentModel.filter(id=contentid)
    content=contentQuery[0]
    
    now = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    
    a=AudithistoryModel.create(userid=user, 
                             contentid=content,
                             method=method,
                             pass_field=pass_field,
                             reason=reason,
                             createtime=now,
                             updatetime=now)
    res=myResponseDict('','')
    return JsonResponse(res,safe=False)

def getAuditHistory (request):
    pageSize=request.GET.get('pageSize')
    pageNo=request.GET.get('pageNo')
    
    AuditHistoryQuery=AudithistoryModel.all()
    paginator=Paginator(AuditHistoryQuery,pageSize)
    totals = paginator.count
    auditHistoryModelList=paginator.get_page(pageNo)
    
    audits=auditWithUserContent_Query2DictList(auditHistoryModelList)
    data={'totals':totals,'audits':audits}
    res=myResponseDict('',data)
    return JsonResponse(res,safe=False)

def bulkAudit(request):
    ids=[]
    ids = request.GET.getlist('ids[]',[])
    typeid = request.GET.get('typeid')

    contentsQuery=contentModel.filter(typeid=typeid)
    for id in ids:
        contentQuery=contentsQuery.filter(id=id)
        
        # 根据query和type对内容进行审核
        # 分类-审核-改content /如果有确定的结果，audit增加一条数据
        result=Audit1Content(contentQuery,typeid)
        
        contentModel.filter(id=id) \
            .update(checkresult=result['checkresult'], lablefrommodel=result['lablefrommodel'], updatetime=result['updatetime'])
        if result['lablefrommodel']!=-1:
            userId = json.loads(request.session.get('user'))['id']
            user=userModel.filter(id=userId)[0]
            content=contentModel.filter(id=id)[0]
            a = AudithistoryModel.create(userid=user,
                                         contentid=content,
                                         method=1,
                                         pass_field=result['pass_field'],
                                         reason=result['reason'],
                                         createtime=result['updatetime'],
                                         updatetime=result['updatetime'])
    res=myResponseDict('','')
    return JsonResponse(res,safe=False)

# 图表： 今日审核占比通过(饼状)
# 图表：过去7天的审核总量(线状)，过去7天审核通过占比(饼状)，过去7天不通过类型占比(饼状)

def todayAuditDetials(request):
    # 今日审核[{pass,数字},{unpass,数字}]           type=1 0，1
    # 7日审核总量 {[日期],[数字]}           type=2 before-after
    # 7日审核通过占比[{pass,数字}，{unpass,数字}]           
    # 7日不通过类型占比 [{reason，数字},{}]         type=4 low-high
    
    todayAudit=[]
    weekAllAudit=[]
    weekProportion=[] 
    weekUnpassCata=[]
      
    now = datetime.now()
    fromTime,toTime=now2FromEnd(now)
    AuditQuery = AudithistoryModel.filter(
        createtime__range=[fromTime, toTime])
    unPassNumber=AuditQuery.filter(pass_field=0).count()
    passNumber = AuditQuery.filter(pass_field=1).count()
    todayAudit.append(unPassNumber)
    todayAudit.append(passNumber)
    ###########################################################
    for i in range(0,7):
        auditNumber=0
        fromTime,toTime=now2FromEnd(now,deltaDay=i,type=1)
        AuditQuery = AudithistoryModel.filter(
            createtime__range=[fromTime, toTime])
        date = fromTime.strftime('%Y-%m-%d')
        auditNumber = AuditQuery.count()
        weekAllAudit.append({'date':date,'number':auditNumber})
    ###########################################################
    fromTime,toTime=now2FromEnd(now,deltaDay=7)
    AuditQuery = AudithistoryModel.filter(
        createtime__range=[fromTime, toTime])
    unPassNumber=AuditQuery.filter(pass_field=0).count()
    passNumber = AuditQuery.filter(pass_field=1).count()
    weekProportion.append(unPassNumber)
    weekProportion.append(passNumber)
    
    reason1or3=AudithistoryModel.filter(Q(reason=1)|Q(reason=3)).count()
    reason2or3=AudithistoryModel.filter(Q(reason=2)|Q(reason=3)).count()
    reason4 = AudithistoryModel.filter(reason=4).count()
    weekUnpassCata.append(reason1or3)
    weekUnpassCata.append(reason2or3)
    weekUnpassCata.append(reason4)
    
    data={'todayAudit':todayAudit,
          'weekAllAudit':weekAllAudit,
          'weekProportion':weekProportion,
          'weekUnpassCata':weekUnpassCata}
    res=myResponseDict('',data)
    return JsonResponse(res)

