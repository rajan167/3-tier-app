import boto3
import json
from datetime import datetime

# This is a custom function defined to handle the serialization of datetime objects to JSON. 
# It takes an object as input and checks if it is an instance of the datetime class. 
# If it is, it converts it to a string in ISO 8601 format using the isoformat() method. 
# If the object is not a datetime, it raises a TypeError indicating that the object is not JSON serializable.

def convert_datetime(obj):
    if isinstance(obj, datetime):
        return obj.isoformat()
    raise TypeError(f"Object of type {obj.__class__.__name__} is not JSON serializable")

# This function takes two parameters: instance_id (the ID of the EC2 instance) and region (the AWS region where the instance is located). 
# It creates an EC2 client using boto3.client('ec2', region_name=region) to interact with the EC2 service in the specified region.

def get_instance_metadata(instance_id, region):
    # Create a Boto3 EC2 client in the specified region
    ec2_client = boto3.client('ec2', region_name=region)

    try:
        # Retrieve the metadata of the specified EC2 instance
        response = ec2_client.describe_instances(InstanceIds=[instance_id])

        # Extract the relevant metadata information
        if 'Reservations' in response and len(response['Reservations']) > 0:
            instance = response['Reservations'][0]['Instances'][0]
            return instance
        else:
            return None
    except Exception as e:
        print("Error:", e)
        return None

def main():
    instance_id = 'i-0bb66580fc38ed425'  # Replace with the actual instance ID
    region = 'us-east-1'    # Replace with the actual region of the EC2 instance

    instance_metadata = get_instance_metadata(instance_id, region)

    if instance_metadata:
        # Convert the metadata to JSON format, handling datetime objects
        json_output = json.dumps(instance_metadata, indent=4, default=convert_datetime)
        print(json_output)
    else:
        print("Instance not found or error occurred.")

# main() function will be executed only when the script is run directly as the main program, 
# not when it is imported as a module into another script.

if __name__ == "__main__":
    main()
