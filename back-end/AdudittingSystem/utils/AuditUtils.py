from AdudittingSystem.forbidden_face_api import FORIDDEN_FACE_API
from AdudittingSystem.sensitive_word_detection import SENSITIVE_WORD_DETECTION
import opennsfw2 as n2
from AdudittingSystem.video_slide import VIDEO_SLIDE, get_time, merge

def pornDetection(path):
    dic = n2.predict_image(path)
    # data_porn={"pornProbability":dic}
    return dic

def faceDetection(path):
    dic = FORIDDEN_FACE_API(path)
    # 前端接收数组，每个元素包含{"name":label,"times",times}有name与times属性
    # 遍历dic的每一个key，把key设置为元素name属性的值，key对应的值设置为元素times属性的值
    # 最后data应为[{"name":"label","times":x}],然后把data作为ans/res的data属性的值(数组)返回前端
    data_face=[]
    for key in dic.keys():
        data_face.append({"name": key, "times": dic[key]})
    return data_face

def faceAndPornDetection(path):
    data_porn=pornDetection(path)
    data_face=faceDetection(path)
    data={"porn":data_porn,"face":data_face}
    return data

def vedioDetection(pathdir):
    data_face=[]
    dic = {}
    typ=0
    data_porn = 0
    for pathdi in pathdir:
        data_porn = max(n2.predict_image(pathdi), typ)
        dic = merge(dic, FORIDDEN_FACE_API(pathdi))
    
    for key in dic.keys():
        data_face.append({"name": key, "times": dic[key]})
 
    data={"porn":data_porn,"face":data_face}
    return data

def sensitiveWordDetection(string):
    dic = SENSITIVE_WORD_DETECTION(string)
    data=[]
    for key in dic.keys():
        data.append({"name": key, "times": dic[key]})
    return data