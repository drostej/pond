import requests
import json
from datetime import datetime

def lambda_handler(event, context):
    # Variablen vorbereiten
    TODAY = datetime.today().strftime('%Y-%m-%d')  # Format: YYYY-MM-DD

    # Platzhalterwerte für die Felder
    pipelines_status = "All pipelines are operational."
    trust_policy_status = "Trust policies are valid."
    icinga_status = "No alerts from Infra Monitoring."
    dx_status = "All Direct Connect lines are up."
    sandbox_spenders = "1. Project A: $1200\n2. Project B: $950\n3. Project C: $800"
    open_pull_requests = "PR-123: Fix pipeline issue\nPR-124: Update monitoring alerts"

    # Payload erstellen
    payload = {
        "type": "message",
        "attachments": [
            {
                "contentType": "application/vnd.microsoft.card.adaptive",
                "contentUrl": None,
                "content": {
                    "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
                    "type": "AdaptiveCard",
                    "version": "1.2",
                    "body": [
                        {"type": "TextBlock", "weight": "Bolder", "size": "ExtraLarge", "text": f"Daily Report - {TODAY}"},
                        {"type": "TextBlock", "text": f"**Pipelines:**\n{pipelines_status}"},
                        {"type": "TextBlock", "text": f"**Trust Policies:**\n{trust_policy_status}"},
                        {"type": "TextBlock", "text": f"**Infra Monitoring (icinga):**\n{icinga_status}"},
                        {"type": "TextBlock", "text": f"**Direct Connect Lines:**\n{dx_status}"},
                        {"type": "TextBlock", "text": f"**Sandbox Top Spenders:**\n{sandbox_spenders}", "wrap": True},
                        {"type": "TextBlock", "text": f"**Open Pull Requests:**\n{open_pull_requests}", "wrap": True},
                    ],
                    "msteams": {"width": "Full"}
                }
            }
        ]
    }

    # Header vorbereiten
    headers = {"Content-Type": "application/json"}

    # URL vorbereiten
    url = "https://prod-09.westeurope.logic.azure.com:443/workflows/10872eb7994e4a8a81019070ad24cb2d/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=FeLWjO38Ln-Q4ITmjm8MD7J-L1yy1d-Niz4JIW3xsEA"

    # Request senden
    response = requests.post(url, headers=headers, data=json.dumps(payload))

    # Ergebnis ausgeben
    if response.status_code in [200, 202]:
        print("Report erfolgreich gesendet!")
        return {"statusCode": 200, "body": "Report erfolgreich gesendet!"}
    else:
        print(f"Fehler beim Senden des Reports. Status Code: {response.status_code}")
        print(response.text)
        return {"statusCode": response.status_code, "body": response.text}

