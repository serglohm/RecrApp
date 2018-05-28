import sys
import logging

logging.basicConfig(filename='telethon.log',level=logging.DEBUG)

from telethon import TelegramClient

chat = sys.argv[1]
api_id = sys.argv[2]
api_hash = sys.argv[3]
session_name = sys.argv[4]
message = sys.argv[5]

client = TelegramClient(session_name, api_id, api_hash)
client.start()
client.send_message(chat, message)
