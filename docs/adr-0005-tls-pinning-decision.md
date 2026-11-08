# ADR-0005: Mobile TLS Verification & Certificate Pinning Decision

## Context
Per `SECURITY.md` Section 14 (Mobile Security Directives) and `[TASK-905]`, the mobile application communicates with the backend API (`https://api.malabak.app`) fronted by Cloudflare WAF and DDoS protection.
A decision is required regarding whether and how to enforce SSL/TLS Certificate Pinning on mobile clients (Android & iOS).

## Threat Model & Considerations
1. **Man-In-The-Middle (MITM) Protection:** Standard TLS verifies server identity against device root CAs. Certificate pinning prevents an attacker who installed a rogue CA certificate on a compromised device from intercepting API traffic.
2. **Cloudflare Edge Rotation:** The production domain uses Cloudflare with automated edge certificate renewals and rotations (every 90 days). If a mobile client pins a specific leaf certificate that Cloudflare rotates, all app instances are permanently bricked until an emergency app update passes Google Play and Apple App Store reviews.
3. **Emergency Rollout Latency:** Store review latency can take 24 to 72 hours, during which all players would experience total service disruption.

## Decision
1. **Enforce Strict HTTPS & Reject Cleartext Traffic:**
   - Android: `android:usesCleartextTraffic="false"` in release builds. Cleartext HTTP is only permitted in debug manifests for local emulator loopback (`10.0.2.2`).
   - iOS: App Transport Security (ATS) is enforced (`NSAllowsArbitraryLoads = false`).
2. **Reject Static Leaf Pinning:**
   - In accordance with `SECURITY.md` Section 14:
     > *"Certificate pinning: يمنع MITM لو الجهاز فيه شهادة مزروعة. بحذر: بتبوظ التطبيق لو الشهادة اتغيّرت. مع Cloudflare الشهادات بتتدور... لو مش جاهز تدير ده، الأفضل ما تعملوش بدل ما تقفل التطبيق على المستخدمين."*
   - Static leaf certificate pinning is explicitly **not** enabled to avoid catastrophic user lockout caused by automated edge rotations.
3. **Fail-Safe Mechanism (Force Update):**
   - Implemented `AppVersionChecker` and `ForceUpdateScreen` (`TASK-905`). If an older app build is compromised or must be decommissioned, the backend signals `minSupportedVersion` which immediately locks obsolete clients and directs users to update from official stores.
4. **Future Enterprise Pinning Path:**
   - If dedicated public key pinning (SPKI) is required in enterprise phases, it must pin at least two backup pins (backup Intermediate CA + Disaster Recovery Root) and support dynamic pin updates before enabling.
