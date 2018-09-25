import os
import re
import hvac

# Using plaintext
client = hvac.Client(url="http://localhost:8200", token=os.environ["VAULT_TOKEN"])

client.write('secret/my-secret', value='s3c(eT', lease='1h')

# print(client.read('secret/my-secret'))
#
# client.delete('secret/my-secret')
#
# print(client.read('secret/my-secret'))

# print(client.kv.v2.read_configuration(mount_point='kv'))
# Configure Vault's secret engine to 'kv' version 2

client.kv.v2.configure(
    max_versions=20,  # Maximum key store
    mount_point='kv',  # Path to secret
)

client.kv.v2.create_or_update_secret(
    path='kv/my-secret',
    secret=dict(foo='s3c(eT'),
    mount_point='kv',
)

print(client.kv.v2.list_secrets(
    path='kv',
    mount_point='kv',
))

print('Secret under path hvac is on version {cur_ver}, with an oldest version of {old_ver}'.format(
    client.kv.v2.read_secret_metadata(path='kv',mount_point='kv')
))

# while True:
#
#     # Get key/value from user
#     # key = input(">>> Enter you key (Type 'Quit' to exit) : ")
#     # if re.fullmatch("^[Qq][Uu][Ii][Tt]$", key):
#     #     break
#     value = input( ">>> Enter you value (Type 'Quit' to exit) : ")
#     if re.match("^[Qq][Uu][Ii][Tt]$", value):
#         break
#
#     # Push key/value to Vault with default 'kv' path
#     client.write("kv/my-key", value=value, lease='1h')
#
#     # Read secret
#     print(client.read('secret/foo'))

# client.kv.v2.create_or_update_secret(
#     path='kv/my-secret',
#     secret=dict(my_key="s3cR3T"),
#     mount_point='kv',
# )
#
# client.kv.v2.list_secrets(
#     path='kv/my-secret',
#     mount_point='kv',
# )
