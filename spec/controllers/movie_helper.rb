require 'rails_helper'
 describe MoviesController, :type => :controller do
    
    describe "#show" do
    before(:each) do
        @movie_new = Movie.create(title: "Memento", rating: "R", description: "Drama/Crime", director: "Nolan", release_date: 20010316)
    end
    
        it "should show" do
            get :show, id: @movie_new[:id]
                expect(response).to render_template(:show)
        end
    end
    
    describe "#index" do
        it "should sort by title" do
            allow(controller).to receive(:params)
            .and_return(sort: "title")
            get :index 
                expect(controller.params[:sort]).to eq "title"
        end
        
        it "should sort by release date" do
            allow(controller).to receive(:params)
            .and_return(sort: "release_date")
            get :index 
                expect(controller.params[:sort]).to eq "release_date"
        end
    end
    
    describe "#new" do
    before(:each) do
        @movie_new = Movie.create(title: "Memento", rating: "R", description: "Drama/Crime", director: "Nolan", release_date: 20010316)
    end
    
        it "add a movie" do
            get :new,  movie_id: @movie_new[:id]
                expect(Movie.find(@movie_new.id)[:title]).to eq("Memento")
        end
    end
    
    describe "#create" do
    before(:each) do
        @movie_create1 = {title: "Dunkirk", rating: "PG-13", description: "Drama/Thriller", director: "Nolan", release_date: 20170721}
        @movie_create2 = {title: "Insomnia", rating: "R", description: "Drama/Mystery", director: "Nolan", release_date: 20020524}
        @movie_create3 = {title: "The Prestige", rating: "PG-13", description: "Science Fiction/Thriller", director: "Nolan", release_date: 20061020}
    end
        
        it "create first movie" do
            post :create, :movie => @movie_create1
                expect(Movie.where(:title => "Dunkirk")).to exist
        end
        
        it "create second movie" do
            post :create, :movie => @movie_create2
                expect(Movie.where(:title => "Insomnia")).to exist
        end
        
        it "create third movie" do
            post :create, :movie => @movie_create3
                expect(Movie.where(:title => "The Prestige")).to exist
        end
    end 
    
    describe "#edit" do
    before(:each) do
        @movie_new = Movie.create(title: "Memento", rating: "R", description: "Drama/Crime", director: "Nolan", release_date: 20010316)
    end
    
        it "should edit" do
            get :edit, id: @movie_new[:id]
                expect(response).to render_template(:edit)
        end
    end
    
    describe "#same_director" do
    before(:each) do
        @movie_1 = Movie.create(:id => "1122", title: "Drama", director: "Cameron")
    end
        
        it "checking movies with a same director" do
            @movie_2 = Movie.create(:id => "3344", title: "Crime", director: "Cameron")
            get :same_director,  id: @movie_2[:id]
                expect(Movie.where(:director => @movie_2.director).size).to eq(2)
        end
        
        it "movies with a different director" do
            @movie_3 = Movie.create(:id => "5566", title: "Thriller", director: "Shankar")
            get :same_director,  id: @movie_3[:id]
                expect(Movie.where(:director => @movie_3.director).size).to eq(1)
        end
    end
    
    describe "#destroy" do
    before(:each) do
        @movie_to_delete = Movie.create(title: "Memento", rating: "R", description: "Drama/Crime", director: "Nolan", release_date: 20010316)
    end
        
        it "delete a movie" do
            expect{ delete :destroy, id: @movie_to_delete[:id]}.to change(Movie, :count).by(-1)
        end
    end 
    
end