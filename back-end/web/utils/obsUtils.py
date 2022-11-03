from obs import ObsClient
from web.utils.BaseConst import AS, SK, OBSENDPOINT, OBSBASCKET, IMGFOLDER, VEDIOFOLDER, OBSPREFIX

obsClient=ObsClient( 
    access_key_id= AS ,
    secret_access_key=SK ,
    server=OBSENDPOINT)

def downloadFromObs(url,toFolder):
    fileUrlInBacket = url.replace(OBSPREFIX, '', 1)
    fileUrlInBacket=fileUrlInBacket.replace('%2F','/')
    fileNameIndex=fileUrlInBacket.rfind('/')
    fileName = fileUrlInBacket[fileNameIndex+1:len(fileUrlInBacket)]
    downloadPath=toFolder+fileName
    
    resp=obsClient.getObject(OBSBASCKET,fileUrlInBacket,downloadPath=downloadPath)
    
    if resp.status<300:
        print('resp.body.url',resp.body.url)
    else:
        print('resp.errorCode',resp.errorCode)
    obsClient.close()
    
    return downloadPath