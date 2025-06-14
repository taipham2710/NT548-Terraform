# NT548-Terraform
Before working with this project, please add the AWS key to github secret
Go to your GitHub repository → Settings → Secrets and variables → Actions, and add these repository secrets:

- AWS_ACCESS_KEY_ID: Your IAM user's access key ID
- AWS_SECRET_ACCESS_KEY: Your IAM user's secret access key


```
GitHub Event Occurs
│
├── Push to main?
│   ├── Yes → terraform-plan (production) → terraform-apply (production) → DEPLOY ✅
│   └── No ↓
│
├── Push to develop?
│   ├── Yes → terraform-plan (development) only → NO DEPLOY
│   └── No ↓
│
├── Push to other branch?
│   ├── Yes → Nothing happens
│   └── No ↓
│
├── Pull Request to main?
│   ├── Yes → terraform-plan (development) + PR comment → NO DEPLOY
│   └── No ↓
│
└── Manual trigger?
    ├── Yes → terraform-plan + terraform-destroy → DESTROY ☠️
    └── No → Nothing happens
```

This line was added to test github action 
