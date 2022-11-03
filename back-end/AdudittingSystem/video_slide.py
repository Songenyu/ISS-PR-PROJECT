import cv2
import time
import subprocess
import shutil
import os


def merge(a, b):
    if len(b.keys()) < len(a.keys()):
        c = a
        a = b
        b = a
    for key in a.keys():
        if key in b.keys():
            b[key] = b[key] + a[key]
        else:
            b[key] = a[key]
    return b


def get_time(path):
    start = time.time()
    cap = cv2.VideoCapture(path)
    duration = -1
    frame_num = -1
    rate = -1
    if cap.isOpened():
        rate = cap.get(5)
        frame_num = cap.get(7)
        duration = frame_num / rate
        end = time.time()
        spend = end - start
        return frame_num, rate, duration
    return frame_num, rate, duration


def VIDEO_SLIDE(path):
    frame_num, rate, duration = get_time(path)
    if duration > 16:
        return "Time Limited"
    elif duration == -1:
        return "Video error"
    path_dir = os.listdir('.')
    if 'video_data' in path_dir:
        shutil.rmtree('video_data')
        os.mkdir('video_data')
    else:
        os.mkdir('video_data')

    videoCapture = cv2.VideoCapture()
    videoCapture.open(path)
    frames = videoCapture.get(cv2.CAP_PROP_FRAME_COUNT)

    nu = 0
    for i in range(int(frames)):
        nu += 1
        ret, frame = videoCapture.read()
        if nu % (int(rate)) == 0:
            cv2.imwrite("video_data//%d.jpg" % i, frame)
    pathdir = os.listdir('video_data')
    for i in range(len(pathdir)):
        pathdir[i] = 'video_data\\' + pathdir[i]
    return pathdir
