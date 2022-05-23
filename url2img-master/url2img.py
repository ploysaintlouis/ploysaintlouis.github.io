#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
from html2image import Html2Image
import qrcode


# In[2]:


hti = Html2Image()


# In[3]:


# data = pd.read_excel('./empid.XLSX', header=1)


# In[4]:


# data[data['sNameEn']=='Hunsa']


# In[5]:


# print(len(data['url']))
# for index in range(len(data['url'])):
#     url = data['url'][index]
#     acc = data['iEmpid'][index]
#     print(index+1, url, acc)
#     hti.screenshot(url=url, save_as=str(acc)+'.png',size=(414, 736))


# In[6]:


# hti.screenshot(url=data['url'][213], save_as=str('10037764')+'.png',size=(414, 736))


# In[7]:


customers =  ['10026898']


# In[8]:


for index in range(len(customers)):
    urlImage = 'https://namecard.thanachartsec.com/card.aspx?emp=' + customers[index]
    hti.screenshot(url=urlImage, save_as=str(customers[index])+'.png',size=(414, 736))
    qr = qrcode.QRCode(
        version=1,
        error_correction=qrcode.constants.ERROR_CORRECT_L,
        box_size=10,
        border=4,
    )
    qr.add_data('https://namecard.thanachartsec.com/index.aspx?emp=' + str(customers[index]))
    qr.make(fit=True)
    imgQR = qr.make_image(fill_color="black", back_color="white")
    imgQR.save(str(customers[index])+'_QR.png')
    print(urlImage)


# In[ ]:




