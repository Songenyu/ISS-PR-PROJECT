import os
from django.shortcuts import render, HttpResponse
from django.http import JsonResponse
from AdudittingSystem.video_slide import VIDEO_SLIDE, get_time, merge
import json
import opennsfw2 as n2
from web.utils.dataUtils import myResponseDict
from AdudittingSystem.utils.AuditUtils import faceAndPornDetection, vedioDetection, sensitiveWordDetection
from web.utils.obsUtils import downloadFromObs, IMGFOLDER, VEDIOFOLDER
# Create your views here.


def detect_sentence(request):
    if request.method == "GET":
        string = request.GET.get('input')
        data=sensitiveWordDetection(string)
        res=myResponseDict('',data)
        return JsonResponse(res,safe=False)


def auditPicture(request):
    if request.method == "GET":
        path = request.GET.get('location')
        delete=0
        if path.startswith('http'):
            path = downloadFromObs(path, IMGFOLDER)
            delete=1
        data = faceAndPornDetection(path)
        if(delete==1):
            if (os.path.exists(path)):   # 判断文件是否存在
                os.remove(path)   # 删除文件
        res = myResponseDict('', data)
        return JsonResponse(res, safe=False)
    
def video_detection(request):
    if request.method == "GET":
        path = request.GET.get('location')
        delete = 0
        if path.startswith('http'):
            path = downloadFromObs(path, VEDIOFOLDER)
            delete = 1
        pathdir = VIDEO_SLIDE(path)
        data=vedioDetection(pathdir)
        if (delete == 1):
            if (os.path.exists(path)):   # 判断文件是否存在
                os.remove(path)   # 删除文件
        res=myResponseDict('',data)       
        return JsonResponse(res, safe=False)
    
