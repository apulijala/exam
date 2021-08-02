mydict = {
    "subnet-public-a" : "10.10.10.0/27",
    "subnet-public-b" : "10.10.10.32/27",
    "subnet-public-c" : "10.10.10.64/27"
}
upper_dict = {}

for key, value in mydict.items():
    upper_dict[key.upper()] = value.upper()
print(upper_dict)

rslt = [ item for item in sorted({
   key.upper() : value.upper() for key, value in mydict.items()
}.keys()) if item.find('B') > 0]


print(rslt)