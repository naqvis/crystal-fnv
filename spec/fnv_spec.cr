require "./spec_helper"

describe FNV do
  it "Test Hashes" do
    # 32bit FNV-1
    digest = Digest::FNV32.digest("foo")
    h = IO::ByteFormat::BigEndian.decode(UInt32, digest) # => 1083137555
    h.should eq(1083137555u32)

    # 32bit FNV-1a
    digest = Digest::FNV32A.digest("foo")
    h = IO::ByteFormat::BigEndian.decode(UInt32, digest) # => 2851307223
    h.should eq(2851307223u32)

    # 64bit FNV-1
    digest = Digest::FNV64.digest("foo")
    h = IO::ByteFormat::BigEndian.decode(UInt64, digest) # => 15621798640163566899
    h.should eq(15621798640163566899u64)

    # 64bit FNV-1a
    digest = Digest::FNV64A.digest("foo")
    h = IO::ByteFormat::BigEndian.decode(UInt64, digest) # => 15902901984413996407
    h.should eq(15902901984413996407u64)

    # 128bit FNV-1
    digest = Digest::FNV128.digest("foo")
    h = IO::ByteFormat::BigEndian.decode(UInt128, digest) # => 221377198890555750482995053501755142603
    h.to_s.should eq("221377198890555750482995053501755142603")

    # 128bit FNV-1a
    digest = Digest::FNV128A.digest("foo")
    h = IO::ByteFormat::BigEndian.decode(UInt128, digest) # => 221385884292107687162785618921601726655
    h.to_s.should eq("221385884292107687162785618921601726655")
  end
end
