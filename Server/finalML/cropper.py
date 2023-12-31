def cropper():
    import os
    import cv2
    from finalML.ml import deepFace
    # Read the input image
    #print(pics)
    c = 1
    import os
    pics = os.listdir('finalML/frames/')
    for i in pics:
        source = "finalML/frames/"
        source += i
        img = cv2.imread(source)
        #print(source,img)
        ph, pl, chan = img.shape
        
        # Convert into grayscale
        gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
        
        # Load the cascade
        face_cascade = cv2.CascadeClassifier('finalML/haarcascade_frontalface_alt2.xml')
        
        # Detect faces
        faces = face_cascade.detectMultiScale(gray, 1.1, 4)
        
        path = "finalML/testingpics"
        # Draw rectangle around the faces and crop the faces
        for (x, y, w, h) in faces:
            picName = "face"
            picName += str(c)
            picName += ".jpg"
            c += 1
            # yi = 0
            # xi = 0
            yh = abs(y-h)
            xl = abs(w-x)
            # xi = int(xl * 0.2)
            # yi = int(yh * 0.2)
            xi = int(w*0.1)
            yi = int(h*0.1)
            if(y - yi < 0):
                yi = 0
            if(x - xi < 0):
                xi = 0
            
            py = img.shape[0]
            px = img.shape[1]
            if(x +w + xi >= px):
                xi = 0
            if( y+h + yi >= py):
                yi = 0
            # print(px,py)
            # print(xi,yi,type(xi),type(yi))
            # print(y-yi,y+h+yi)
            # print(x-xi,x+w+xi)
            #cv2.rectangle(img, (x, y), (x+w, y+h), (0, 0, 255), 2)
            faces = img[y-yi:y + h+yi, x-xi:x + w+xi]
            #faces =  img
            #print(picName)
            cv2.imwrite(os.path.join(path ,picName), faces)
    attendance = deepFace(c)
    print(attendance)
    return attendance