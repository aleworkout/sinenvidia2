if Rails.env.production?
  aws = {
    access_key_id: "AKIAJGRXQD2TKYEQOR3A", 
    secret_access_key: "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", 
    bucket: "bucketaleworkout",
  } 
  Refile.cache = Refile::Backend::S3.new(prefix: "cache", **aws)
  Refile.store = Refile::Backend::S3.new(prefix: "store", **aws)
  else
      Refile.backends['store'] = Refile::Backend::FileSystem.new(Rails.root.join('tmp').to_s)
end
