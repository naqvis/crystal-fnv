# Crystal-FNV

Implements 32, 64 and 128 bits FNV-1 and FNV-1a [Fowler–Noll–Vo hash function](http://www.isthe.com/chongo/tech/comp/fnv/index.html). FNV is a non-cryptographic hash function created by
Glenn Fowler, Landon Curt Noll, and Phong Vo. Refer to [Wikipedia](https://en.wikipedia.org/wiki/Fowler-Noll-Vo_hash_function) for more details.


## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     fnv:
       github: naqvis/crystal-fnv
   ```

2. Run `shards install`

## Usage

```Crystal
require "fnv"

# 32bit FNV-1
digest = Digest::FNV32.digest("foo")
p IO::ByteFormat::BigEndian.decode(UInt32, digest) # => 1083137555

# 32bit FNV-1a
digest = Digest::FNV32A.digest("foo")
p IO::ByteFormat::BigEndian.decode(UInt32, digest) # => 2851307223

# 64bit FNV-1
digest = Digest::FNV64.digest("foo")
p IO::ByteFormat::BigEndian.decode(UInt64, digest) # => 15621798640163566899

# 64bit FNV-1a
digest = Digest::FNV64A.digest("foo")
p IO::ByteFormat::BigEndian.decode(UInt64, digest) # => 15902901984413996407

# 128bit FNV-1
digest = Digest::FNV128.digest("foo")
p IO::ByteFormat::BigEndian.decode(UInt128, digest) # => 221377198890555750482995053501755142603

# 128bit FNV-1a
digest = Digest::FNV128A.digest("foo")
p IO::ByteFormat::BigEndian.decode(UInt128, digest) # => 221385884292107687162785618921601726655

```

## Contributing

1. Fork it (<https://github.com/naqvis/crystal-fnv/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Ali Naqvi](https://github.com/naqvis) - creator and maintainer
