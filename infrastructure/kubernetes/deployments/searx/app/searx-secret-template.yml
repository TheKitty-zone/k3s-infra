---
apiVersion: v1
kind: Secret
metadata:
  name: searxng-config
data:
  settings.yml: |-
    config:
        use_default_settings: true
        general:
          enable_metrics: true
        server:
          secret_key: 
          image_proxy: true
          http_protocol_version: "1.0"
        ui:
          theme_args:
            simple_style: dark
        search:
          autocomplete: "qwant"
          autocomplete_min: 4
          default_lang: "en-US"
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