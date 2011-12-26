%include header title='FutureMe'
<div class="hero-unit">
  <h1>Enter your information</h1>
  <p>Enter your information here to see what your health will look like in the future.</p>
</div>

<div class="span16">
  <form action="/chart" method="post">
    <fieldset>
      <legend>Information</legend>
      <div class="clearfix">
        <label for="firstName">First Name</label>
        <div class="input">
          <input class="span" id="firstName" name="firstName" size="30" type="text" />
        </div>
      </div><!-- /clearfix -->
      <div class="clearfix">
        <label for="lastName">Last Name</label>
        <div class="input">
          <input class="span" id="lastName" name="lastName" size="30" type="text" />
        </div>
      </div><!-- /clearfix -->
        <div class="clearfix">
          <label id="genderOptionsRadio">Sex</label>
          <div class="input">
            <ul class="inputs-list">
              <li>
                <label>
                  <input type="radio" checked name="genderOptionsRadio" value="M" />
                  <span>Male</span>
                </label>
              </li>
              <li>
                <label>
                  <input type="radio" name="genderOptionsRadio" value="F" />
                  <span>Female</span>
                </label>
              </li>
            </ul>
          </div>
        </div><!-- /clearfix -->
      <div class="clearfix">
        <label for="ageField">Age</label>
        <div class="input">
          <input class="span" id="ageField" name="ageField" size="3" type="text" />
        </div>
      </div><!-- /clearfix -->
      <div class="clearfix">
        <label for="weightField">Weight</label>
        <div class="input">
          <input class="span" id="weightField" name="weightField" size="3" type="text" />
        </div>
      </div><!-- /clearfix -->
      <div class="clearfix">
        <label for="heightFeet">Height (ft.)</label>
        <div class="input">
          <input class="span" id="heightFeet" name="heightFeet" size="1" type="text" />
        </div>
      </div><!-- /clearfix -->
      <div class="clearfix">
        <label for="heightInches">(in.)</label>
        <div class="input">
          <input class="span" id="heightInches" name="heightInches" size="1" type="text" />
        </div>
      </div><!-- /clearfix -->
      <div class="clearfix">
        <label for="bloodPressureSystolic">Blood Pressure (sys.)</label>
        <div class="input">
          <input class="span" id="bloodPressureSystolic" name="bloodPressureSystolic" size="3" type="text" />
        </div>
      </div><!-- /clearfix -->
      <div class="clearfix">
        <label for="bloodPressureDiastolic">(dia.)</label>
        <div class="input">
          <input class="span" id="bloodPressureDiastolic" name="bloodPressureDiastolic" size="3" type="text" />
        </div>
      </div><!-- /clearfix -->
      <fieldset>
        <div class="clearfix">
          <label id="diseasesCheckboxes">Diseases</label>
          <div class="input">
            <ul class="inputs-list">
              <li>
                <label>
                  <input type="checkbox" name="diseasesCheckboxes" value="heartdisease" />
                  <span>Heart Disease</span>
                </label>
              </li>
              <li>
                <label>
                  <input type="checkbox" name="diseasesCheckboxes" value="stroke" />
                  <span>Stroke</span>
                </label>
              </li>
              <li>
                <label>
                  <input type="checkbox" name="diseasesCheckboxes" value="kidneydisease" />
                  <span>Kidney Disease</span>
                </label>
              </li>
            </ul>
          </div>
        </div><!-- /clearfix -->
      </fieldset>
      <div class="actions">
        <button type="submit" class="btn primary">Submit &raquo;</button>
        <button type="reset" class="btn">Cancel</button>
      </div>
      <div class="clearfix">
        <p>Practice fusion patient?</p>
        <img src="/static/images/patient_fusion_logo.png" width="310" height="97" alt="patient_fusion_connect">
      </div>
    </fieldset>
  </form>
</div>

%include footer

