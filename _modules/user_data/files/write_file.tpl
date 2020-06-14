write_files:
%{ for file in Files ~}
- encoding: b64
  content: ${file.Content}
  owner: root:root
  path: ${file.Path}
  permissions: '0644'
%{ endfor ~}
