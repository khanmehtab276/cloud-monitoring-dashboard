import psutil
import json
from datetime import datetime
from flask import Flask, jsonify, render_template

app = Flask(__name__)


def get_cpu_metrics():
    """Get CPU usage metrics"""
    return {
        'percent': psutil.cpu_percent(interval=1),
        'count': psutil.cpu_count(logical=True)
    }


def get_memory_metrics():
    """Get memory usage metrics"""
    mem = psutil.virtual_memory()
    return {
        'percent': mem.percent,
        'used_gb': round(mem.used / (1024**3), 2),
        'total_gb': round(mem.total / (1024**3), 2)
    }


def get_disk_metrics():
    """Get disk usage metrics"""
    disk = psutil.disk_usage('/')
    return {
        'percent': disk.percent,
        'used_gb': round(disk.used / (1024**3), 2),
        'total_gb': round(disk.total / (1024**3), 2)
    }


@app.route('/health', methods=['GET'])
def health():
    """Health check endpoint"""
    return jsonify({'status': 'healthy', 'timestamp': datetime.now().isoformat()}), 200


@app.route('/api/metrics', methods=['GET'])
def metrics():
    """Get all system metrics"""
    try:
        data = {
            'timestamp': datetime.now().isoformat(),
            'cpu': get_cpu_metrics(),
            'memory': get_memory_metrics(),
            'disk': get_disk_metrics()
        }
        return jsonify(data), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500


@app.route('/', methods=['GET'])
def dashboard():
    """Serve dashboard"""
    return render_template('dashboard.html')


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=False)
