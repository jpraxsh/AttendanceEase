import os
import shutil
from collections import Counter

def func(x,pic):
    
    d = Counter()
    count = Counter()
    print(x)
    for i in range(len(x)):
        l = x[i][0]
        y = x[i][1]        
        if(y>0.75):
            continue
            #return "None"
        else:
            l=l.split("/")
            print(l)
            l=l[1]
            l=l.split("\\")
            l=l[1]
            d[l] += y
            count[l] += 1
    print(d,count)
    least = 10000
    ans = ""
    for i in d:
        dev = d[i]/count[i]
        if(dev < least):
            least = dev
            ans = i
    print(least,ans)
    if(least <= 0.4):
        origin = pic
        target = "finalML/training/" + ans + "/"
        filename = os.listdir("finalML/training/" + ans )
        filename = filename[-1][4:]
        filename = filename[:-4]
        print(filename)
        shutil.copy(origin, target+"newi"+str(int(filename)+1) + ".jpg")
    return ans

def deepFace(c):
    from deepface import DeepFace
    attendance = set()
    for i in range(1,c):
        model1 = DeepFace.build_model("VGG-Face")
        picpath = "D:/Projects/classMonitior/Server/finalML/testingpics/face"
        picpath += str(i)
        picpath += ".jpg"
        print(picpath)
        try:
            df = DeepFace.find(img_path = picpath, db_path = "finalML/training",distance_metric = "euclidean_l2",model=model1,model_name = "VGG-Face")
        #print(df)
        except:
            print("hi")
            continue
        if(df.size > 0):
            x=df.to_numpy()
            r = func(x,picpath)
            print(r)
            if(len(r) >0):
                attendance.add(r)
            # print(x)
            # l=x[0][0]
            # y = x[0][1]
            # print(y)
            # if(y>0.70):
            #     l = "none"
            #     print("none")
            #     # return l
            # else:
            #     l=l.split("/")
            #     print(l)
            #     l=l[5]
            #     l=l.split("\\")
            #     l=l[1]
            #     print(l)
            #     attendance.add(l)
            # # return l;
        else:
            print("none")

    print("\n\nATTENDANCE:\n")
    l = list(attendance)
    for i in l:
        print(i)
    import os
    return list(attendance)
 
    # dir = 'frames'
    # for f in os.listdir(dir):
    #     os.remove(os.path.join(dir, f))
    # dir = 'testingpics'
    # for f in os.listdir(dir):
    #     os.remove(os.path.join(dir, f))
        # return "none"
# def deepFace():
#     from deepface import DeepFace
#     model1 = DeepFace.build_model("VGG-Face")
#     picpath = "E:/Face Recognition CNN/face1.jpg"
#     #picpath += "2.jpg"
#     df = DeepFace.find(img_path = '', db_path = "./Trainset",distance_metric = "euclidean_l2",model=model1,model_name = "VGG-Face")
#     print(df)
    
#     if(df.size > 0):
#             x=df.to_numpy()
#             print(x)
#             l=x[0][0]
#             y = x[0][1]
#             print(y)
#             if(y>0.65):
#                 l = "none"
#                 print("none")
#                 # return l
#             else:
#                 l=l.split("/")
#                 print(l)
#                 l=l[1]
#                 l=l.split("\\")
#                 l=l[1]
#                 print(l)
#             # return l;
#     else:
#         print("none")
#         # return "none"
# deepFace()