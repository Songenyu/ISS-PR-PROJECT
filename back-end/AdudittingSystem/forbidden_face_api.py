import face_recognition
import time
import os
import cv2
import json


def face_dataset_baseline():
    # get the path of forbidden face save in forbidden_face_dataset
    forbidden_face_dataset = []
    path = os.getcwd() + "\\project\\forbidden_dataset"
    for file in os.listdir(path):
        forbidden_face_dataset.append(os.path.join(path, file))

    # load each image and get encoding
    forbidden_face_encoding = []
    for image_path in forbidden_face_dataset:
        label = image_path.split('\\')[-1].split('.')[0]
        face_locations = face_recognition.face_locations(face_recognition.load_image_file(image_path))
        forbidden_face_encoding.append([label,
                                        face_recognition.face_encodings(face_recognition.load_image_file(image_path),
                                                                        face_locations)[0]])
    return forbidden_face_encoding


def FORIDDEN_FACE_API(path_test):
    forbidden_face_encoding = face_dataset_baseline()
    # print('forbidden_face_encoding',forbidden_face_encoding)
    face_locations = face_recognition.face_locations(face_recognition.load_image_file(path_test))
    test_data_encoding = []
    for x in face_locations:
        test_data_encoding.append(face_recognition.face_encodings(face_recognition.load_image_file(path_test), [x])[0])
    ans = {}
    for y in test_data_encoding:
        for x in forbidden_face_encoding:
            results = face_recognition.compare_faces([x[1]], y, tolerance=0.40)
            if results[0]:
                if x[0] in ans.keys():
                    ans[x[0]] += 1
                else:
                    ans[x[0]] = 1
    return ans



