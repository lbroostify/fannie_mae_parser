# # INFO Don't print anything with puts when running tests. Please use Rails.logger.
unless ENV['RM_INFO']
  def puts(*args)
    super and return if args.empty?

    # args.each do |str|
    #   Rails.logger.warn str
    # end
  end
end
