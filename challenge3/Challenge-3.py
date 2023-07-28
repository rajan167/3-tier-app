
nested_object = {"a": {"b": {"c": "d"}}}
key1 = "a/b"
key2 = "a"

def get_value_by_key(obj, key):
    keys = key.split('/')
    for k in keys:
        if isinstance(obj, dict) and k in obj:
            obj = obj[k]
        else:
            return None
    return obj

result1 = get_value_by_key(nested_object, key1)
result2 = get_value_by_key(nested_object, key2)

print(result1)  # Output: {'c': 'd'}
print(result2)  # Output: {'b': {'c': 'd'}}
