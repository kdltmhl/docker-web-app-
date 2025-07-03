# Dockerfile

# 1. Das Basis-Image festlegen
# Wir starten mit einem offiziellen Image von Node.js.
# Die Version 20-alpine ist klein und sicher, ideal für die Produktion.
# 'alpine' bezieht sich auf eine minimalistische Linux-Distribution.
FROM node:20-alpine

# 2. Das Arbeitsverzeichnis im Container festlegen
# Alle nachfolgenden Befehle werden in diesem Verzeichnis ausgeführt.
# Wenn der Ordner nicht existiert, wird er hier erstellt.
WORKDIR /usr/src/app

# 3. Die package.json und package-lock.json kopieren
# Diese Dateien definieren die Abhängigkeiten unseres Projekts.
# Wir kopieren sie zuerst, damit Docker die Installation der Abhängigkeiten
# zwischenspeichern kann. Das beschleunigt spätere Builds enorm,
# solange sich die Abhängigkeiten nicht ändern.
COPY package*.json ./

# 4. Die Projekt-Abhängigkeiten installieren
# 'npm ci' (clean install) ist die empfohlene Methode für automatisierte
# Umgebungen. Es stellt sicher, dass exakt die Versionen aus der
# package-lock.json installiert werden.
RUN npm ci

# 5. Den restlichen Quellcode der App kopieren
# Jetzt, wo die Abhängigkeiten installiert sind, kopieren wir
# den restlichen Code unserer Anwendung in den Container.
COPY . .

# 6. Den Port freigeben
# Wir teilen Docker mit, dass unsere Anwendung im Container
# auf Port 3000 lauschen wird.
EXPOSE 3000

# 7. Den Startbefehl definieren
# Dieser Befehl wird ausgeführt, wenn der Container startet.
# 'npm start' ist eine Konvention, um die Anwendung zu starten.
# Wir werden diesen Befehl später in unserer package.json definieren.
CMD [ "npm", "start" ]