""" This is my first DSA practice file. 
    Here I will be trying to solve the ARRAY problems 
    """
    
    
# 1. Reverse the array and string *************-------------------**********************************

a = [2,5,7,9,4,2,0]

# Direct is like use the slicing 

print(a[::-1])

#try using other methods like for loop and all

reversed_list = []
for i in a:
    reversed_list.insert(0,i)
    
print(reversed_list)

# Same for strigs as well. As they are also indexed items in python.




# 2. FInd the maximun and minimum element in an array -------------********---------------------------



a = [2,5,7,9,4,2,0]

def sum_of_min_and_max(list1):

    maxi, mini = "", ""

    for i in range(len(list1)):
        if i == 0 :
            maxi, mini = list1[i],list1[i]
            continue
        elif maxi < list1[i]:
            maxi = list1[i]
            continue
        elif mini > list1[i]:
            mini = list1[i]

    print(maxi+mini)
    
sum_of_min_and_max([1,3.32,7.9,6,4,3,2,69,3]) 
