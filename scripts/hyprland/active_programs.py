#!/usr/bin/env python3

import subprocess
import json

def get_clients():
    # Call hyprctl to get the clients in JSON format
    result = subprocess.run(['hyprctl', '-j', 'clients'], capture_output=True, text=True)
    return json.loads(result.stdout)

def main():
    # Get the list of clients
    clients = get_clients()

    # Create a list of client names and their corresponding workspace IDs
    client_info = [
        {
            'name': f"{client['class']} ({client['title']})",
            'workspace_id': client['workspace']['id']
        }
        for client in clients
    ]

    # Extract names for the rofi menu
    names = [client['name'] for client in client_info]

    # Use rofi to select a client
    selected_name = subprocess.run(['rofi', '-dmenu' ,'-i'], input='\n'.join(names), text=True, capture_output=True).stdout.strip()

    # Find the selected client information
    selected_client = next((client for client in client_info if client['name'] == selected_name), None)

    # Output the selected client and its workspace ID
    if selected_client:
        workspace_str = str(selected_client['workspace_id'])
        subprocess.run(['hyprctl', 'dispatch', 'workspace', workspace_str], input='\n'.join(names), text=True)
    else:
        print("No client selected or found.")

if __name__ == "__main__":
    main()
