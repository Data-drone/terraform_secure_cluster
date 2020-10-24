# Bind IPA LDAP

This role needs to bind the ldap in FreeIPA to CM

Tasks:

- create the ipa bind user - done
- add the cacert to java - done
- update cm settings - stuck

```{bash}

# curl command
curl -i -v -uadmin:admin -X PUT --header 'Content-Type: application/json' --header 'Accept: application/json' -d '@request.json' 'https://ip-10-0-1-242.ap-southeast-2.compute.internal:7183/api/v41/cm/config'

```

Ranger UserSync

```{json}



```

Hue settings

```{json}
{
  "items" : [ {
    "name" : "auth_backend",
    "value" : "desktop.auth.backend.LdapBackend,desktop.auth.backend.AllowFirstUserDjangoBackend"
  }, {
    "name" : "base_dn",
    "value" : "cn=accounts,dc=seccluster,dc=local"
  }, {
    "name" : "bind_dn",
    "value" : "uid=cm_bind,cn=users,cn=accounts,dc=seccluster,dc=local"
  }, {
    "name" : "bind_password",
    "value" : "{{ ldap_bind_pass }}"
  }, {
    "name" : "ldap_cert",
    "value" : "/etc/ipa/ca.crt"
  }, {
    "name" : "ldap_url",
    "value" : "{{ ldap_protocol }}{{ groups['security'][0] }}"
  }{
    "name" : "group_filter",
    "value" : "(objectClass=posixGroup)"
  }, {
    "name" : "group_member_attr",
    "value" : "memberUid"
  }, {
    "name" : "group_name_attr",
    "value" : "cn"
  }, {
    "name" : "test_ldap_group",
    "value" : "cdp_users"
  }, {
    "name" : "test_ldap_user",
    "value" : "cm_user"
  }, {
    "name" : "user_filter",
    "value" : "(objectClass=posixAccount)"
  }, {
    "name" : "user_name_attr",
    "value" : "uid"
  }]
}

```

# Knox and LDAP

```{json}
# config item is under
# knox gateway roleConfigGroup
# configs:

"roleConfigGroups" : [ {
      "refName" : "knox-KNOX_GATEWAY-BASE",
      "roleType" : "KNOX_GATEWAY",
      "configs" : [ {
        "name" : "gateway_sso_authentication_provider",
        "value" : "role=authentication#authentication.name=ShiroProvider#authentication.param.sessionTimeout=30#authentication.param.redirectToUrl=/${GATEWAY_PATH}/knoxsso/knoxauth/login.html#authentication.param.restrictedCookies=rememberme,WWW-Authenticate#authentication.param.urls./**=authcBasic#authentication.param.main.ldapRealm=org.apache.knox.gateway.shirorealm.KnoxLdapRealm#authentication.param.main.ldapContextFactory=org.apache.knox.gateway.shirorealm.KnoxLdapContextFactory#authentication.param.main.ldapRealm.contextFactory=$ldapContextFactory#authentication.param.main.ldapRealm.contextFactory.authenticationMechanism=simple#authentication.param.main.ldapRealm.contextFactory.url={{ ldap_protocol }}{{ groups['security'][0] }}#authentication.param.main.ldapRealm.contextFactory.systemUsername=uid=cm_bind,cn=users,cn=accounts,dc=seccluster,dc=local#authentication.param.main.ldapRealm.contextFactory.systemPassword={{ ldap_bind_pass }}#authentication.param.main.ldapRealm.userDnTemplate=uid={0},cn=users,cn=accounts,dc=seccluster,dc=local"
      }, {
        "name" : "gateway_knox_admin_groups",
        "value" : "cdp_admins"
      }

## jinjaed
"roleConfigGroups" : [ {
      "refName" : "knox-KNOX_GATEWAY-BASE",
      "roleType" : "KNOX_GATEWAY",
      "configs" : [ {
        "name" : "gateway_sso_authentication_provider",
        "value" : "role=authentication#authentication.name=ShiroProvider#authentication.param.sessionTimeout=30#authentication.param.redirectToUrl=/${GATEWAY_PATH}/knoxsso/knoxauth/login.html#authentication.param.restrictedCookies=rememberme,WWW-Authenticate#authentication.param.urls./**=authcBasic#authentication.param.main.ldapRealm=org.apache.knox.gateway.shirorealm.KnoxLdapRealm#authentication.param.main.ldapContextFactory=org.apache.knox.gateway.shirorealm.KnoxLdapContextFactory#authentication.param.main.ldapRealm.contextFactory=$ldapContextFactory#authentication.param.main.ldapRealm.contextFactory.authenticationMechanism=simple#authentication.param.main.ldapRealm.contextFactory.url=ldaps://ip-10-0-1-140.ap-southeast-2.compute.internal#authentication.param.main.ldapRealm.contextFactory.systemUsername=uid=cm_bind,cn=users,cn=accounts,dc=seccluster,dc=local#authentication.param.main.ldapRealm.contextFactory.systemPassword=cmBindPass1#authentication.param.main.ldapRealm.userDnTemplate=uid={0},cn=users,cn=accounts,dc=seccluster,dc=local"
      }, {
        "name" : "gateway_knox_admin_groups",
        "value" : "admin,cdp_admins"
      }

```