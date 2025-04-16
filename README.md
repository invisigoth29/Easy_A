# 🛠️ Easy_A

A collection of tools, scripts, and automation workflows designed to make a Microsoft 365 administrator’s life easier — from day-to-day management to advanced reporting and security monitoring.

---

## 🚀 Purpose

Managing Microsoft 365 environments involves user provisioning, security auditing, policy enforcement, reporting, and more — often across multiple portals and products.

**This project provides reusable, automation-friendly components to:**

- Streamline common admin tasks
- Enhance visibility with reports & alerts
- Integrate Azure, Entra ID, Exchange, SharePoint, Teams, and Defender
- Enable secure, scalable cloud-native automation using Microsoft Graph

---

## ✅ Key Features

- 🔐 Secure app-only Graph API access
- 🧠 Risk-based sign-in monitoring
- 🧰 Reusable PowerShell modules & Graph queries
- ☁️ Automation-ready (Azure Automation, Cloud Shell, GitHub Actions)


---

## 📁 What's Included

| Component                   | Description                                                  |
|-----------------------------|--------------------------------------------------------------|
| `scripts/`                  | PowerShell & Graph API scripts for common admin tasks        |
| `automation/`               | ARM templates, deploy scripts, and scheduler configs         |
| `alerts/`                   | Teams/email alerting scripts and integrations                |
| `docs/`                     | Setup guides, use cases, Graph API permissions               |
| `README.md`                 | This file                                                   |

---

## 📦 Example Use Cases

Eye_of_Sauron👁️ – The unblinking eye can’t find Frodo but it’s great for IP and domain lookup. 

Gandalf🧙  – Need to stop a Balrog or phish email? Creates a transport rule & block the phishy sender or domain. 

RiskLevel⚠️ – Check for Entra risky sign-ins without a browser 

Dyson💨 – The content search that never loses suction. After you’ve contained the email threat with Gandalf, get Dyson clean out those emails.

Revoken_a_token🎫 – User account compromised? Revoke that token! Don’t wait for password replication! Revoke the MFA token and remediate the threat in seconds!


---

## ⚙️ Quick Start

1. **Clone the Repo**
   ```bash
   git clone https://github.com/yourorg/m365-admin-toolkit.git
   cd m365-admin-toolkit
   ```

2. **Register a Graph App**
   - Permissions: `User.Read.All`, `AuditLog.Read.All`, `Reports.Read.All`, etc.
   - Create a client secret or cert
   - Save `ClientId`, `TenantId`, `Secret`

3. **Run a Script**
   ```powershell
   ./scripts/get-user-license-report.ps1
   ```

4. **Deploy Automation (Optional)**
   ```powershell
   ./automation/deploy-schedule.ps1
   ```

---

## 🔐 Security Notes

- Use app-only auth for automation
- Secure secrets via Azure Key Vault or GitHub Secrets
- Grant minimum viable permissions

---

## 📌 Roadmap Ideas

- [ ] GUI frontend (Teams, PWA, or Portal)
- [ ] Role-based access summary & alerts
- [ ] Unified log archiving
- [ ] Graph + Power Automate hybrid flows

---

## 🤝 Contributing

Feel free to open issues, suggest improvements, or submit pull requests!  
Let’s make M365 administration smarter and less painful.

---

## 🪪 License

MIT License — see [LICENSE](LICENSE) for details.

---

## 🙏 Support

If this saves you time — give it a ⭐ and share with fellow admins.
