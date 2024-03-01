# frozen_string_literal: true

json.array! @whitelists, partial: 'whitelists/whitelist', as: :whitelist
