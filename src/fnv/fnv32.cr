require "digest/base"

class Digest::FNV32 < Digest::Base
  private OFFSET = 2166136261_u32
  private PRIME  =   16777619_u32

  def initialize
    @hash = OFFSET
  end

  def update(data)
    data.to_slice.each do |b|
      @hash &*= PRIME
      @hash ^= b.to_u32
    end
  end

  def final
  end

  def result
    result = Bytes.new(sizeof(UInt32))
    IO::ByteFormat::BigEndian.encode(@hash, result)
    result
  end

  def reset
    @hash = OFFSET
  end

  def sum : UInt32
    @hash
  end
end

class Digest::FNV32A < Digest::Base
  private OFFSET = 2166136261_u32
  private PRIME  =   16777619_u32

  def initialize
    @hash = OFFSET
  end

  def update(data)
    data.to_slice.each do |b|
      @hash ^= b.to_u32
      @hash &*= PRIME
    end
  end

  def final
  end

  def result
    result = Bytes.new(sizeof(UInt32))
    IO::ByteFormat::BigEndian.encode(@hash, result)
    result
  end

  def reset
    @hash = OFFSET
  end

  def sum : UInt32
    @hash
  end
end
