require "digest/digest"

class Digest::FNV32 < Digest
  extend Digest::ClassMethods

  private OFFSET = 2166136261_u32
  private PRIME  =   16777619_u32

  def initialize
    @hash = OFFSET
  end

  def update_impl(data : Bytes) : Nil
    data.to_slice.each do |b|
      @hash &*= PRIME
      @hash ^= b.to_u32
    end
  end

  def final_impl(result : Bytes) : Nil
    IO::ByteFormat::BigEndian.encode(@hash, result)
  end

  def result
    result = Bytes.new(sizeof(UInt32))
    IO::ByteFormat::BigEndian.encode(@hash, result)
    result
  end

  def digest_size : Int32
    sizeof(UInt32)
  end

  def reset_impl : Nil
    @hash = OFFSET
  end

  def sum : UInt32
    @hash
  end
end

class Digest::FNV32A < Digest
  extend Digest::ClassMethods
  private OFFSET = 2166136261_u32
  private PRIME  =   16777619_u32

  def initialize
    @hash = OFFSET
  end

  def update_impl(data : Bytes) : Nil
    data.to_slice.each do |b|
      @hash ^= b.to_u32
      @hash &*= PRIME
    end
  end

  def final_impl(result : Bytes) : Nil
    IO::ByteFormat::BigEndian.encode(@hash, result)
  end

  def result
    result = Bytes.new(sizeof(UInt32))
    IO::ByteFormat::BigEndian.encode(@hash, result)
    result
  end

  def digest_size : Int32
    sizeof(UInt32)
  end

  def reset_impl : Nil
    @hash = OFFSET
  end

  def sum : UInt32
    @hash
  end
end
