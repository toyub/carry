namespace :customer_asset do

  desc "recover asset name"

  task recover_asset_name: :environment do
    StoreCustomerAssetItem.all.each do |item|
      if item.name.blank?
        item.update(name: item.package_item.name) if item.package_item.present?
      end
    end
  end
end
