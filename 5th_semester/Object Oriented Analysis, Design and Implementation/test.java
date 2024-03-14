class test{
    private test(){

    }


    public static class Builder{
        String title;

        public Builder setTitle(String title){
            this.title = title;
            return this;
        }
        public Builder setDescription(String description){
            return this;
        }
        public test build(){
            return new test();
        }
    }

    public static void main(String[] args) {
        Builder builder = new Builder();
        test t = builder
            .setTitle("something")
            .setDescription("somethingelse")
            .build();

    }
}