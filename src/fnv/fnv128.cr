require "digest/digest"

class Digest::FNV128 < Digest
  extend Digest::ClassMethods
  private OFFSET_H = 0x6c62272e07bb0142_u64
  private OFFSET_L = 0x62b821756295c58d_u64
  private PRIME_L  =              0x13b_u64
  private PRIME_S  =                 24_u64

  def initialize
    @hash = [OFFSET_H, OFFSET_L]
  end

  def update_impl(data : Bytes) : Nil
    data.to_slice.each do |b|
      # compute the multiplication
      s0, s1 = mul64(PRIME_L, @hash[1])
      s0 &+= (@hash[1] << PRIME_S) &+ (PRIME_L &* @hash[0])
      # update the values
      @hash[1] = s1
      @hash[0] = s0
      @hash[1] ^= b.to_u64
    end
  end

  def final_impl(result : Bytes) : Nil
    val = IO::Memory.new
    @hash.each do |h|
      IO::ByteFormat::BigEndian.encode(h, val)
    end
    result.copy_from(val.to_slice.to_unsafe, result.size)
  end

  def result
    result = IO::Memory.new
    @hash.each do |h|
      IO::ByteFormat::BigEndian.encode(h, result)
    end
    result.rewind
    result.to_slice
  end

  def digest_size : Int32
    sizeof(UInt128)
  end

  def reset_impl : Nil
    @hash = [OFFSET_H, OFFSET_L]
  end

  def sum
    @hash
  end
end

class Digest::FNV128A < Digest
  extend Digest::ClassMethods
  private OFFSET_H = 0x6c62272e07bb0142_u64
  private OFFSET_L = 0x62b821756295c58d_u64
  private PRIME_L  =              0x13b_u64
  private PRIME_S  =                 24_u64

  def initialize
    @hash = [OFFSET_H, OFFSET_L]
  end

  def update_impl(data : Bytes) : Nil
    data.to_slice.each do |b|
      @hash[1] ^= b.to_u64
      # compute the multiplication
      s0, s1 = mul64(PRIME_L, @hash[1])
      s0 &+= (@hash[1] << PRIME_S) &+ (PRIME_L &* @hash[0])
      # update the values
      @hash[1] = s1
      @hash[0] = s0
    end
  end

  def final_impl(result : Bytes) : Nil
    val = IO::Memory.new
    @hash.each do |h|
      IO::ByteFormat::BigEndian.encode(h, val)
    end
    result.copy_from(val.to_slice.to_unsafe, result.size)
  end

  def result
    result = IO::Memory.new
    @hash.each do |h|
      IO::ByteFormat::BigEndian.encode(h, result)
    end
    result.rewind
    result.to_slice
  end

  def digest_size : Int32
    sizeof(UInt128)
  end

  def reset_impl : Nil
    @hash = [OFFSET_H, OFFSET_L]
  end

  def sum
    @hash
  end
end

private MASK32 = (1_i64 << 32) - 1

# returns the 128-bit product of x and y: (hi, lo) = x * y
# with the product bits' upper half returned in hi and lower
# half returned in lo

# :nodoc:
def self.mul64(x : UInt64, y : UInt64) : {UInt64, UInt64}
  x0 = x & MASK32
  x1 = (x >> 32)
  y0 = y & MASK32
  y1 = (y >> 32)
  w0 = x0 &* y0
  t = x1 &* y0 &+ (w0 >> 32)
  w1 = t & MASK32
  w2 = (t >> 32)
  w1 &+= x0 &* y1
  hi = x1 &* y1 &+ w2 &+ (w1 >> 32)
  lo = x &* y
  {hi, lo}
end
