import requests, codecs, json
from time import sleep


class RpcClient:
    def __init__(self, url):
        self.url = url
        self.headers = { 'content-type': 'application/json' }
    def call(self, method, *params):
        payload = json.dumps({ "method": method, "params": list(params), "jsonrpc": "2.0", "id": 1})
        sleep(0.1)
        response = requests.post(self.url, data=payload, headers=self.headers, timeout=3)
        res = response.json()
        if response.status_code != 200 and res['error'] is not None:
            raise Exception(res['error'])
        return res['result']

class BtcClient:
    def __init__(self):
        self.rpc = RpcClient('http://user:password@192.168.50.4:18443')
    def __getattr__(self, method):
        def missing_method(*args, **kwargs):
            return self.rpc.call(method, *args)
        return missing_method
    def generate(self, n, wait_sec=2):
        address = self.rpc.call('getnewaddress')
        blocks  = self.rpc.call('generatetoaddress', n, address)
        sleep(wait_sec)
        return blocks

enc = lambda path: codecs.encode(open(path, 'rb').read(), 'hex')

class LndClient:
    def __init__(self, host, port):
        self.url = 'https://192.168.50.4:' + port + '/v1'
        self.sec = { 'headers': {'Grpc-Metadata-macaroon': enc('/lnd_share/' + host + '/admin.macaroon') }, 'verify': '/lnd_share/' + host + '/tls.cert' }
    def get(self, res, params={}):
        return requests.get(self.url + res, **self.sec, data=json.dumps(params)).json()
    def post(self, res, params={}):
        return requests.post(self.url + res, **self.sec, data=json.dumps(params)).json()
    def delete(self, res, params={}):
        return requests.delete(self.url + res, **self.sec, params={})
