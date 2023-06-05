class ZeroCouponBond:

    def __init__(self, principal: int, maturity: int, interest_rate: int):
        self.principal = principal
        self.maturity = maturity
        self.interest_rate = interest_rate / 100

    def peresent_value(self, x, n):
        return x / (1+self.interest_rate)**n

    def calculate_price(self):
        return self.peresent_value(self.principal, self.maturity)


if __name__ == "__main__":
    z_bond = ZeroCouponBond(principal=1000, maturity=2, interest_rate=4)
    print(z_bond.calculate_price())
