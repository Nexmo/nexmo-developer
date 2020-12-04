class SimpleRandom
  class InvalidSeedArgument < StandardError; end

  C_32_BIT = 4294967296
  F_32_BIT = 4294967296.0

  def initialize
    @m_w = 521288629
    @m_z = 362436069
  end

  def set_seed(*args)
    validate_seeds!(*args)

    @m_w, @m_z = if args.size > 1
      args[0..1].map(&:to_i)
    elsif args.first.is_a?(Numeric)
      [@m_w, args.first.to_i]
    else
      generate_temporal_seed(args.first || Time.now)
    end

    @m_w %= C_32_BIT
    @m_z %= C_32_BIT
  end

  # Produce a uniform random sample from the open interval (lower, upper).
  def uniform(lower = 0, upper = 1)
    fail ArgumentError, 'Upper bound must be greater than lower bound.' unless lower < upper

    ((get_unsigned_int + 1) * (upper - lower) / F_32_BIT) + lower
  end

  # Sample normal distribution with given mean and standard deviation
  def normal(mean = 0.0, standard_deviation = 1.0)
    fail ArgumentError, 'Standard deviation must be strictly positive' unless standard_deviation > 0

    mean + standard_deviation * ((-2.0 * Math.log(uniform)) ** 0.5) * Math.sin(2.0 * Math::PI * uniform)
  end

  # Get exponential random sample with specified mean
  def exponential(mean = 1)
    fail ArgumentError, "Mean must be strictly positive" unless mean > 0

    -1.0 * mean * Math.log(uniform)
  end

  # Get triangular random sample with specified lower limit, mode, upper limit
  def triangular(lower, mode, upper)
    fail ArgumentError, 'Upper bound must be greater than lower bound.' unless lower < upper
    fail ArgumentError, 'Mode must lie between the upper and lower limits' if mode > upper || mode < lower

    f_c = (mode - lower) / (upper - lower)
    uniform_rand_num = uniform

    if uniform_rand_num < f_c
      lower + Math.sqrt(uniform_rand_num * (upper - lower) * (mode - lower))
    else
      upper - Math.sqrt((1 - uniform_rand_num) * (upper - lower) * (upper - mode))
    end
  end

  # Implementation based on "A Simple Method for Generating Gamma Variables"
  # by George Marsaglia and Wai Wan Tsang.  ACM Transactions on Mathematical Software
  # Vol 26, No 3, September 2000, pages 363-372.
  def gamma(shape, scale)
    fail ArgumentError, 'Shape must be strictly positive' unless shape > 0

    base = if shape < 1
      gamma(shape + 1.0, 1.0) * uniform ** -shape
    else
      d = shape - 1 / 3.0
      c = (9 * d) ** -0.5

      begin
        z = normal

        condition1 = z > (-1.0 / c)
        condition2 = false

        if condition1
          u = uniform
          v = (1 + c * z) ** 3
          condition2 = Math.log(u) < (0.5 * (z ** 2) + d * (1.0 - v + Math.log(v)))
        end
      end while !condition2

      d * v
    end

    scale * base
  end

  def chi_square(degrees_of_freedom)
    gamma(0.5 * degrees_of_freedom, 2.0)
  end

  def inverse_gamma(shape, scale)
    1.0 / gamma(shape, 1.0 / scale)
  end

  def beta(a, b)
    fail ArgumentError, "Parameters must be strictly positive" unless a > 0 && b > 0
    u = gamma(a, 1)
    v = gamma(b, 1)
    u / (u + v)
  end

  def weibull(shape, scale)
    fail ArgumentError, 'Shape and scale must be positive' unless shape > 0 && scale > 0

    scale * ((-Math.log(uniform)) ** (1.0 / shape))
  end

  def cauchy(median, scale)
    fail ArgumentError, 'Scale must be positive' unless scale > 0

    median + scale * Math.tan(Math::PI * (uniform - 0.5))
  end

  def student_t(degrees_of_freedom)
    fail ArgumentError, 'Degrees of freedom must be strictly positive' unless degrees_of_freedom > 0

    normal / ((chi_square(degrees_of_freedom) / degrees_of_freedom) ** 0.5)
  end

  def laplace(mean, scale)
    u_1 = uniform(-0.5, 0.5)
    u_2 = uniform

    sign = u_1 / u_1.abs
    mean + sign * scale * Math.log(1 - u_2)
  end

  def log_normal(mu, sigma)
    Math.exp(normal(mu, sigma))
  end

  def dirichlet(*parameters)
    sample = parameters.map { |a| gamma(a, 1) }
    sum = sample.inject(0.0) { |sum, g| sum + g }
    sample.map { |g| g / sum }
  end

  private

  # This is the heart of the generator.
  # It uses George Marsaglia's MWC algorithm to produce an unsigned integer.
  # See http://www.bobwheeler.com/statistics/Password/MarsagliaPost.txt
  def get_unsigned_int
    @m_z = 36969 * (@m_z & 65535) + (@m_z >> 16);
    @m_w = 18000 * (@m_w & 65535) + (@m_w >> 16);
    ((@m_z << 16) + (@m_w & 65535)) % 4294967296
  end

  def validate_seeds!(*args)
    return true if args.compact.empty?

    unless args[0].to_f.abs > 0
      fail InvalidSeedArgument, 'Seeds must be strictly positive'
    end

    unless args[1].nil? || args[1].to_f.abs > 0
      fail InvalidSeedArgument, 'Seeds must be strictly positive'
    end

    true
  end

  def generate_temporal_seed(timestamp = Time.now)
    x = (timestamp.to_f * 1000000).to_i

    [x >> 16,  x % 4294967296]
  end

  def gamma_function(x)
    return 1e308 if x > 171.0

    if x.to_f == x.to_i
      return unless x > 0
      return 1 if x.to_i == 1

      (1...x).inject(&:*)
    else
      z = if x.abs > 1.0
        x.abs - x.abs.to_i
      else
        x
      end

      gr = GAMMA_VALUES.inject(GAMMA_NAUGHT) do |sum, g|
        sum * z + g
      end

      r = if x.abs > 1
        (1..(x.abs.to_i)).inject(1.0) { |prod, i| prod * (x.abs - i) }
      else
        1.0
      end

      if x < 0 && x.abs > 1
        -Math::PI * gr * z / (x * r * Math.sin(Math::PI * x))
      else
        r / (gr * z)
      end
    end
  end

  GAMMA_NAUGHT = 0.14e-14

  GAMMA_VALUES = [
    -5.4e-15,
    -2.06e-14,
    5.1e-13,
    -3.6968e-12,
    7.7823e-12,
    1.043427e-10,
    -1.1812746e-09,
    5.0020075e-09,
    6.116095e-09,
    -2.056338417e-07,
    1.133027232e-06,
    -1.2504934821e-06,
    -2.01348547807e-05,
    0.0001280502823882,
    -0.0002152416741149,
    -0.0011651675918591,
    0.007218943246663,
    -0.009621971527877,
    -0.0421977345555443,
    0.1665386113822915,
    -0.0420026350340952,
    -0.6558780715202538,
    0.5772156649015329,
    1.0
  ]
end
