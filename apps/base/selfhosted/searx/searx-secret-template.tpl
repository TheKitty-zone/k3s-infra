---
apiVersion: v1
kind: Secret
metadata:
  name: searxng-config
  namespace: selfhosted
stringData:
  settings.yml: |-
    use_default_settings: true
    general:
      enable_metrics: true
      instance_name: "Search the kitty zone"
    server:
      secret_key: ""
      image_proxy: true
      http_protocol_version: "1.0"
    ui:
      theme_args:
        simple_style: dark
    search:
      autocomplete: "qwant"
      autocomplete_min: 4
      default_lang: "en-US"
    enabled_plugins:
      # these plugins are enabled if nothing is configured ..
      - 'Hash plugin'
      - 'Search on category select'
      - 'Self Information'
      - 'Tracker URL remover'
      # these plugins are disabled if nothing is configured ..
      - 'Hostname replace'  # see hostname_replace configuration below
      - 'Vim-like hotkeys'
      - 'Tor check plugin'
    hostname_replace:
      '(.*\.)?youtube\.com$': 'watch.thekitty.zone'
      '(.*\.)?youtu\.be$': 'watch.thekitty.zone'
      '(.*\.)?youtube-noocookie\.com$': 'watch.thekitty.zone'
      '(.*\.)?reddit\.com$': 'reddit.thekitty.zone'
      '(.*\.)?redd\.it$': 'reddit.thekitty.zone'
      '(www\.)?twitter\.com$': 'nitter.pussthecat.org'
    engines:
      - name: invidious
        disabled: false
        base_url:
          - https://watch.thekitty.zone