# Consul

Powershell Helper Functions for HashiCorp Consul

HashiCorp Consul is a Service Discovery and configuration app.  More information can be found here: https://www.consul.io/

These Powershell scripts are helper functions that assist in utilizing Consul.

###Resources

- **Convert-ConsulMessage**
  - Converts HashiCorp's Consul log text into an object.  This object can then be used to send to SEQ or other Log tools.
  
  - **`[String]`Message** (_Mandatory_): Consul log message.
