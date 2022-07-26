class BaseCollection
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def results
    @results ||= begin
      ensure_filters
      relation
    end
  end

  def meta
    { total: total, count: count }
  end

  def total
    @total ||= results.size
  end

  def count
    @count ||= @relation.count
  end

  private

  def filter
    @relation = yield(relation)
  end

  def relation
    raise NotImplementedError
  end

  def ensure_filters
    raise NotImplementedError
  end
end
