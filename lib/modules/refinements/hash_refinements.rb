module HashRefinements

  refine Hash do
    def stringify_keys
      reduce({}) do |hash, (key, value)|
        hash[key.to_s] = value
        hash
      end
    end

    def except!(*keys)
      keys.each do |key|
        delete(key)
      end
      self
    end

    def except(*keys)
      dup.except! *keys
    end

    def fetch! key
      [fetch(key), except(key)]
    end
  end

end
