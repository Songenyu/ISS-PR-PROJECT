"""project URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from drf_yasg2 import openapi
from drf_yasg2.views import get_schema_view
from rest_framework import permissions
from django.contrib import admin
from django.urls import path, include
from rest_framework_swagger.views import get_swagger_view
from AdudittingSystem import views
# from web.views import index

urlpatterns = [
        
    # 相关模型的接口，具体对应的是AduittingSystem 下的views.py接收
    path('detectSentence/', views.detect_sentence),
    path('auditPicture/', views.auditPicture),
    path('videoDetection/', views.video_detection),
    
    ###############################################
    
    # 平台的通用接口，这里相当于做了一个分流的作用，与平台有关的以web/开头
    # 然后不同的平台接口去 web下的urls里去找
    path('web/',include('web.urls')),
]
