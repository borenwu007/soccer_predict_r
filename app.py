from flask import request, Flask, jsonify, render_template
from flask_bootstrap import Bootstrap 
from predict import update_file, get_predict
from flask_cors import CORS


app = Flask(__name__)
bootstrap = Bootstrap(app)
CORS(app)



@app.route('/<name>')
def index(name):
    return render_template('index.html',name=name)

@app.route('/api/predict', methods=['POST'])
def predict():
    leagure = request.json.get('leagure')
    team_h = request.json.get('team_h')
    team_a = request.json.get('team_a')

    if team_h.find(' ') >= 0:
        team_h = team_h.replace(' ','20%')
    if team_a.find(' ') >= 0:
        team_a = team_a.replace(' ','20%')
    
    result = get_predict(leagure, team_h, team_a)
    recognize_info = {'code': 200, 'result': result}
    return jsonify(recognize_info)

@app.route('/api/update', methods=['POST'])
def update():
    leagure = request.form['leagure']
    result = update_file(leagure)
    return jsonify(result), 200



if __name__ == "__main__":
    print("server is running on 5000")
    app.run(port=5000, host='0.0.0.0', debug=True)