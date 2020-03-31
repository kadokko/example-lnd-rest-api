import json
import time


def p(data='', end=None):
    print(data, end=end)

def dump(data):
    print(json.dumps(data, indent=2))

def generate_blocks(client, block_num, wait_sec=0):
    return [time.sleep(wait_sec), client.generatetoaddress(block_num, client.getnewaddress())]