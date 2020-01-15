from flask import request, Flask, jsonify, render_template
from flask_bootstrap import Bootstrap 
from predict import update_file, get_predict


app = Flask(__name__)
bootstrap = Bootstrap(app)


@app.route('/<name>')
def index(name):
    return render_template('index.html',name=name)

@app.route('/api/predict', methods=['POST'])
def predict():
    leagure = request.form['leagure']
    team_h = request.form['team_h']
    team_a = request.form['team_a']

    result = get_predict(leagure, team_h, team_a)
    recognize_info = {'code': 200, 'result': result}
    return jsonify(recognize_info), 200

@app.route('/api/update', methods=['POST'])
def update():
    leagure = request.form['leagure']
    result = update_file(leagure)
    return jsonify(result), 200



if __name__ == "__main__":
    print("server is running on 5000")
    app.run(port=5000, host='0.0.0.0', debug=True)