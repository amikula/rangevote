class Poll < ActiveRecord::Base
  serialize :candidates
  has_many :votes

  Result = Struct.new(:candidate, :total, :count, :quorum)
  class Result
    attr_accessor :candidate, :total, :count, :quorum

    def initialize(candidate, total, count, quorum)
      self.candidate = candidate
      self.total = total
      self.count = count
      self.quorum = quorum
    end

    def average
      if count == 0
        0
      else
        total / count.to_f
      end
    end

    def quorum?
      quorum
    end
  end

  def results
    retval = nil
    if votes.count > 0
      retval = []
      candidates.each{|candidate| retval << Result.new(candidate, 0, 0, false)}
      votes.each do |vote|
        retval.each_index do |i|
          if vote.ratings[i] != "X"
            retval[i].total += vote.ratings[i]
            retval[i].count += 1
          end
        end
      end

      max_score = retval.inject(0) {|max,result| result.total > max ? result.total : max}
      quorum_score = max_score / 2.0

      retval.each do |result|
        result.quorum = ((result.total >= quorum_score) ? true : false)
      end

      retval.sort! {|a,b| b.average <=> a.average}
    end

    return retval
  end
end
