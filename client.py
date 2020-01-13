import requests,json
 
url = 'http://127.0.0.1:8000/predict'
data = {'team_h':'Inter','team_a':'Atalanta'}
r =requests.post(url,data)
# print(r)
# print(r.text)
# print(r.content)
result = r.json()

print(result)
print(type(result))
print(result[0])