# Baseball Data Integration for Salesforce

This Salesforce DX project demonstrates an API-driven data integration pipeline: Salesforce Flow and Apex code retrieve SportsData.io game data by date, map external identifiers to Salesforce records, and model game and inning data in custom objects for score reporting.

<img width="637" height="293" alt="Screenshot 2026-11-22 201021" src="https://github.com/user-attachments/assets/4a70a3f5-5f06-44d6-b3a4-dcf5a443600b" />

## What it does

- Calls an external baseball data service through Salesforce External Services.
- Uses a Salesforce Flow to retrieve games by date and create Game and Inning records.
- Uses invocable Apex actions to map external team, stadium, and game identifiers to Salesforce records.
- Displays teams, runs, hits, errors, and inning scores with a Lightning Web Component on the Game record page.
- Models games, teams, stadiums, and innings as custom Salesforce objects.

<img width="954" height="338" alt="Screenshot 2026-11-22 201259" src="https://github.com/user-attachments/assets/eaaa6e8b-2625-4347-b0ba-2a26d49dc090" />
<img width="903" height="351" alt="Screenshot 2026-11-22 201222" src="https://github.com/user-attachments/assets/3e54e67d-7dc7-48cd-a319-21bd8ce695b5" />


## Technologies

- **Salesforce Platform:** Salesforce Flow, External Services, custom objects, fields, layouts, and Lightning record pages
- **Apex:** Invocable actions for resolving external IDs and preparing related records
- **Lightning Web Components:** JavaScript, HTML, and CSS for the game line score
- **Salesforce DX:** Salesforce CLI and source-formatted metadata
- **JavaScript tooling:** ESLint, Prettier, and Jest-based LWC unit testing

<img width="340" height="332" alt="Screenshot 2026-11-22 201124" src="https://github.com/user-attachments/assets/34988cf1-44b1-4dfd-b22d-7989ac826168" />

## Setup and deployment

### Prerequisites

- A Salesforce org with permission to deploy metadata and use the required Salesforce features.
- Salesforce CLI (`sf`).
- Node.js and npm for the JavaScript tooling.
- Access to the baseball data service used by the External Service registration.

### Connect to an org

```bash
sf org login web --alias baseball-dev
```

Configure the org's External Services and the `Sports_Data` Named Credential for the target environment. Keep environment-specific authentication details out of source control.

### Install development dependencies and deploy

```bash
npm install
sf project deploy start --target-org baseball-dev --source-dir force-app
```

After deployment, activate the relevant Flow and configure the app or record page for the org as needed.
