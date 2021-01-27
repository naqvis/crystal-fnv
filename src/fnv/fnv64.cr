require "digest/digest"

class Digest::FNV64 < Digest
  extend Digest::ClassMethods
  private OFFSET = 14695981039346656037_u64
  private PRIME  =        1099511628211_u64

  def initialize
    @hash = OFFSET
  end

  def update_impl(data : Bytes) : Nil
    data.to_slice.each do |b|
      @hash &*= PRIME
      @hash ^= b.to_u64
    end
  end

  def final_impl(result : Bytes) : Nil
    IO::ByteFormat::BigEndian.encode(@hash, result)
  end

  def result
    result = Bytes.new(sizeof(typeof(@hash)))
    IO::ByteFormat::BigEndian.encode(@hash, result)
    result
  end

  def digest_size : Int32
    sizeof(typeof(@hash))
  end

  def reset_impl : Nil
    @hash = OFFSET
  end

  def sum : UInt64
    @hash
  end
end

class Digest::FNV64A < Digest
  extend Digest::ClassMethods
  private OFFSET = 14695981039346656037_u64
  private PRIME  =        1099511628211_u64

  def initialize
    @hash = OFFSET
  end

  def update_impl(data : Bytes) : Nil
    data.to_slice.each do |b|
      @hash ^= b.to_u64
      @hash &*= PRIME
    end
  end

  def final_impl(result : Bytes) : Nil
    IO::ByteFormat::BigEndian.encode(@hash, result)
  end

  def result
    result = Bytes.new(sizeof(typeof(@hash)))
    IO::ByteFormat::BigEndian.encode(@hash, result)
    result
  end

  def digest_size : Int32
    sizeof(typeof(@hash))
  end

  def reset_impl : Nil
    @hash = OFFSET
  end

  def sum : UInt64
    @hash
  end
end
