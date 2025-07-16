## Bereitstellung eines pyton scrips mit python in ein zipfile
## 1: Deployment-Paket erstellen
Erstelle ein Verzeichnis für das Deployment-Paket:

```mkdir lambda_packag```

Kopiere die Abhängigkeiten aus dem Virtual Environment:

```
cp -r venv/lib/python3.11/site-packages/* lambda_package/
```

Hinweis: Passe python3.11 an deine Python-Version an.

Füge deine Lambda-Funktionsdatei hinzu:

```
cp lambda_function.py lambda_package/
```

Erstelle ein ZIP-Archiv des Deployment-Pakets:


```
cd lambda_package
zip -r ../lambda_function_package.zip .```
```
### Schritt 3: Deployment in AWS Lambda
AWS Management Console:

Gehe zu AWS Lambda in der Management Console.
Wähle deine Lambda-Funktion aus.
Gehe zu Code → Upload from → .zip file und lade die Datei lambda_function_package.zip hoch.
Terraform (falls verwendet): Passe den Terraform-Code an, um das ZIP-Paket hochzuladen:

resource "aws_lambda_function" "my_lambda" {
function_name = "my_lambda_function"
role          = aws_iam_role.lambda_role.arn
handler       = "lambda_function.lambda_handler"
runtime       = "python3.11"
filename      = "lambda_function_package.zip"
source_code_hash = filebase64sha256("lambda_function_package.zip")
}
```

Führe Terraform aus:

```
Code kopieren
terraform apply
```

### Schritt 4: Testen der Funktion
In der AWS Management Console:

Führe ein Test-Event in der Lambda-Konsole aus.
Überprüfe die Logs in CloudWatch Logs, um sicherzustellen, dass die Bibliothek korrekt geladen wird.
Logs überprüfen:

Gehe zu CloudWatch Logs und überprüfe, ob Fehler beim Laden der Bibliothek auftreten.
Alternative: Lambda Layers verwenden
Statt die Bibliothek in jedes Deployment-Paket zu integrieren, kannst du einen Lambda Layer erstellen, um requests zu teilen.

## Layer erstellen:

Installiere requests in einem separaten Verzeichnis:
bash
Code kopieren
mkdir layer
pip install requests -t layer/python
cd layer
zip -r ../requests_layer.zip .
Layer hochladen:

* Gehe zu AWS Lambda → Layers → Create Layer.
* Lade die Datei requests_layer.zip hoch.
* Layer der Funktion hinzufügen:

Bearbeite deine Lambda-Funktion und füge den Layer in den Layer-Einstellungen hinzu.

## Hindernisse beim Widerverwenden

data "aws_vpc" "pond_vpc" {
  id = "vpc-0a59e06dbd3297c94"  # ID der Sandbox vpc
}

Es gibt hier auch immer den promt

MBP-von-Jurgen [ls] ~/dev/projects/pond/infrastructure/terraform                                                                                                                                                 25-05-23  3:55PM
drostej@MBP-von-Jurgen terraform % tofu plan     
var.subnet_id_eur_cent_1
  The ID of the public subnet to use for the ECS service.

  Enter a value: vpc-0a59e06dbd3297c94

data.aws_vpc.pond_vpc: Reading...
data.aws_vpc.pond_vpc: Read complete after 1s [id=vpc-0a59e06dbd3297c94]
