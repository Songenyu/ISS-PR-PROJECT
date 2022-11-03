from django.urls import path,re_path
from web import views

urlpatterns = [
        path('userNameLogin/', views.userNameLogin),
        path('getLoginUser/',views.getLoginUser),
        path('getContentByTypeId/',views.getContentByTypeId),
        path('updateContenAuditResult/',views.updateContenAuditResult),
        path('insertHistory/',views.insertHistory),
        path('getAuditHistory/',views.getAuditHistory),
        path('bulkAudit/',views.bulkAudit),
        path('todayAuditDetials/',views.todayAuditDetials),
]