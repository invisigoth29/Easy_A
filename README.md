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
- 📋 User & license reporting
- 🧠 Risk-based sign-in monitoring
- 📬 Email & Teams alerting
- 🧰 Reusable PowerShell modules & Graph queries
- ☁️ Automation-ready (Azure Automation, Cloud Shell, GitHub Actions)
- 🔁 Scheduling support with ARM templates or cron equivalents

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

- Generate license usage & user role reports
- Alert on sign-ins from high-risk countries
- Monitor for inactive accounts or stale guests
- Auto-remediate risky accounts via Graph API
- Post daily audit summaries to Teams
- Schedule admin tasks every 15/30/60 minutes

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
