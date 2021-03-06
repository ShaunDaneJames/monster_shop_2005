class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip

  belongs_to :user
  has_many :item_orders
  has_many :items, through: :item_orders
  enum status: %w(pending packaged shipped cancelled)

  def grandtotal
    item_orders.sum('price * quantity')
  end

  def total_order_items
    item_orders.sum(:quantity)
  end

  def all_fulfilled?
    item_orders.all? do |item_order|
      item_order.status == "fulfilled"
    end
  end

  def packaged_status
    if all_fulfilled?
      self.update(status: 1)
    end
  end

  def self.packaged_orders
    self.where(status: "packaged")
  end

  def self.pending_orders
    self.where(status: "pending")
  end

  def self.shipped_orders
    self.where(status: "shipped")
  end

  def self.cancelled_orders
    self.where(status: "cancelled")
  end
end
