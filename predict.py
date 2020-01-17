import requests
import json
import pandas as pd


def get_predict(leagure, team_h, team_a):
    with open('config.json', 'r') as f:
        config = json.load(f)
    url = config["url"]
    data = {'leagure': leagure, 'team_h': team_h, 'team_a': team_a}

    r = requests.post(url, data)
    result = r.json()

    # df = pd.DataFrame(result)
    return result


def update_file(leagure):
    with open('config.json', 'r') as f:
        file_dict = json.load(f)

        file_url = file_dict[leagure]["url"]
        file_name = file_dict[leagure]["file"]

    r = requests.get(file_url)
    with open(file_name, "wb") as code:
        code.write(r.content)
    
    return {'code':200,'info':'update finish'}


if __name__ == "__main__":
    update_file('Italy_a')
    result = get_predict('Italy_a', 'Parma', 'Roma')
    df = pd.DataFrame(result)
    print(df)
    